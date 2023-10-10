# frozen_string_literal: true

Administrator.create!(
  email:                 "admin@sixty.inc",
  password:              "1234567890",
  password_confirmation: "1234567890"
)

user = User.create!(email: "foo@bar.com")

account = GoogleAccount.create!(
  user: user,
  email: "foo@bar.com",
)

calendar = GoogleCalendar.create!(remote_id: "foo@bar.com")

GoogleCalendarInstance.create!(account: account, calendar: calendar)
