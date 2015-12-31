require 'faker'

admin = User.create!(name: "Isaac", email: "isamol1@nilesk12.org", admin: true, loggedin: true, image: Faker::Avatar.image)
