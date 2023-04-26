User.create!(
    name: "Jhon",
    email: "jhon@example.com",
    password: "password",
    password_confirmation: "password",
    confirmed_at: Time.now,
    role: "admin"
  )
  