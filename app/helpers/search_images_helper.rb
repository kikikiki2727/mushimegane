module SearchImagesHelper
  def upload_image(data)
    credentials = Aws::Credentials.new(
      Rails.application.credentials.aws[:access_key_id],
      Rails.application.credentials.aws[:secret_access_key]
    )
    region = 'ap-northeast-1'

    # アップロードされた画像をs3に保存
    s3_client = Aws::S3::Client.new(region: region, credentials: credentials)

    body = data
    bucket = 'bug-images-search'
    key = 'bug_image'

    s3_client.put_object({
                           body: body,
                           bucket: bucket,
                           key: key
                         })

    put_labels(credentials, bucket, key, s3_client, region)
  end

  def put_labels(credentials, bucket, key, s3_client, region)
    # 保存した画像を使ってラベルを検出
    rekogniton_client = Aws::Rekognition::Client.new(credentials: credentials, region: region)
    attrs = {
      image: {
        s3_object: {
          bucket: bucket,
          name: key
        }
      },
      max_labels: 10
    }

    response = rekogniton_client.detect_labels attrs
    label_list = []
    response.labels.each do |label|
      label_list << label.name.downcase
    end

    # ラベル検出に使用した画像を削除
    s3_client.delete_objects({
                               bucket: bucket,
                               delete: {
                                 objects: [
                                   {
                                     key: key
                                   }
                                 ],
                                 quiet: false
                               }
                             })

    translate_label(credentials, label_list, region)
  end

  def translate_label(credentials, label_list, region)
    # ラベルを翻訳
    translate_client = Aws::Translate::Client.new(
      region: region,
      credentials: credentials
    )

    label_list_ja = []

    label_list.each do |label|
      res = translate_client.translate_text({
                                              text: label,
                                              source_language_code: 'auto',
                                              target_language_code: 'ja'
                                            })
      label_list_ja << res.translated_text
    end

    # ラベルのリストを返す
    label_list_ja
  end

  def label_search(label_list)
    relation = Bug.includes(image_attachment: :blob).distinct

    result = []

    label_list.each do |label|
      relation.where('name LIKE ?', "%#{label}%")
              .or(relation.where('feature LIKE ?', "%#{label}%"))
              .or(relation.where('approach LIKE ?', "%#{label}%"))
              .or(relation.where('prevention LIKE ?', "%#{label}%"))
              .or(relation.where('harm LIKE ?', "%#{label}%"))
              .each { |bug| result << bug }
    end
    bugs_array = result.uniq
  end
end
