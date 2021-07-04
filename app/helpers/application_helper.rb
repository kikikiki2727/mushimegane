module ApplicationHelper
  def image_search
    require 'aws-sdk-rekognition'
    credentials = Aws::Credentials.new(
       ENV['AWS_ACCESS_KEY_ID'],
       ENV['AWS_SECRET_ACCESS_KEY']
    )
    
    bucket = 'bug-image-search' # the bucket name without s3://
    photo  = 'ゴキブリ画像2.jpeg' # the name of file
    client   = Aws::Rekognition::Client.new(credentials: credentials)
    attrs = {
      image: {
        s3_object: {
          bucket: bucket,
          name: photo
        },
      },
      max_labels: 10
    }
    response = client.detect_labels attrs
    label_list = []
    response.labels.each do |label|
      label_list << label.name
    end
    label_list
  end
end
