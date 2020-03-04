# Digital Signage

This web app is designed to be self-hosted digital signage software. Right now the only content supported is video. The usecase is that there's a cental content producers and they can give that content to users that can display to their patrons.

In short think of muesums or stores with TV displays in the corners of locations with videos playing relavent to the area.

# Demo
*actual server setup instructions to follow soon*

After running the seeds, navigate to localhost:3000/kiosk/1 and localhost:3000/kiosks, and after clicking the video player in `/kiosk/1` you'll be able to play/pause the video via the buttons in `/kiosks`

Want to create a new kiosk? Navigate to `localhost:3000/link` and `localhost:3000/kiosk` and input a name and the kiosk code into the fields in `/link` and the `/kiosk` should refresh to the kiosk link, and now `/kiosks` should have two buttons each able to control different kiosk video players.