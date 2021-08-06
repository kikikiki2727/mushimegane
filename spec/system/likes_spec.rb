require 'rails_helper'

RSpec.describe 'Likes', type: :system do
  let(:bug) { create(:bug) }
  let!(:radar_chart) { create(:radar_chart, bug: bug) }
  let(:comment) { create(:comment, bug: bug) }

  it 'いいねボタンを押すとカウントされ、再度押すと解除される' do
    visit bug_path(comment.bug)
    find('.like_button').click
    expect(find('.comment')).to have_content 1
    find('.unlike_button').click
    expect(find('.comment')).to have_content 0
  end
end
