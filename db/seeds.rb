# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create auth-user
auth_user = AuthUser.create(email: "seed_user@example.com", password: "password")
auth_user.save!

# create user
user = User.create!(auth_user_id: auth_user.id)

# create show
show = Show.create!( title: "Show 1" )

# create episode
episode = Episode.create!( title: "Episode 1", show: show )

# create segment
file_location = "./db/seed_files/"
segment1 = Segment.create!( title: "Segment 1" )
segment1_filename = "Show1-E01SEG01.mp4"
segment1_file = File.open(file_location + segment1_filename)
segment1.video.attach(io: segment1_file, filename: segment1_filename)
segment1.save!

segment2 = Segment.create!( title: "Segment 2" )
segment2_filename = "Show1-E01SEG02.mp4"
segment2_file = File.open(file_location + segment2_filename)
segment2.video.attach(io: segment2_file, filename: segment2_filename)
segment2.save!
# create episode-segment

episode_segment1 = EpisodeSegment.create!( episode: episode, segment: segment1, order_number: 1 )
episode_segment2 = EpisodeSegment.create!( episode: episode, segment: segment2, order_number: 2 )

# create kiosk
kiosk = Kiosk.create!( code:"ABCD", playable_id: show.playable_id, name: "Front Lobby" )

# create user kiosk
user_kiosk = UserKiosk.create!( user: user, kiosk: kiosk )