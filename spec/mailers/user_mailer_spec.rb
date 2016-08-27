require 'rails_helper'
include ActiveJob::TestHelper

RSpec.describe UserMailer, type: :mailer do
  let(:user) { FactoryGirl.create(:user) }

  it 'job is created' do
    ActiveJob::Base.queue_adapter = :test
    expect {
      UserMailer.welcome_email(user).deliver_later
    }.to have_enqueued_job.on_queue('mailers')
  end

  it 'welcome_email is sent' do
    expect {
      perform_enqueued_jobs do
        UserMailer.welcome_email(user).deliver_later
      end
    }.to change { ActionMailer::Base.deliveries.size }.by(1)
  end

  it 'welcome_email is sent to the right user' do
      perform_enqueued_jobs do
          UserMailer.welcome_email(user).deliver_later
      end

      mail = ActionMailer::Base.deliveries.last
      expect(mail.to[0]).to eq user.email
  end
end
