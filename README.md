# Seltzer Ratings

Rate the seltzers you drink!

## To Do
No reviewed seltzer data to display --> Update cloud_firestore version ?

Require unique usernames

Cheers/Comment state management

User profile pics

Favorite Seltzers

Fix logout

## Help Needed

Comment State Management


/lib/widgets/reviews/cheers_comment.dart

/lib/widgets/reviews/add_comment.dart

Desired behavior: When I click the 'COMMENT' button, I want to toggle the display of the form that allows a user to enter + submit a comment

Problem: When I call setState from within cheers_comment.dart, the entire widget tree rebuilds, causing a new call to the Firestore to pull in information, which causes a weird flash behavior in the UI. I don't really want the entire widget tree to rebuild, so I tried moving the setState call into add_comment.dart but I can't figure out how to link the 'COMMENT' button in cheers_comment.dart to the function within add_comment.dart



Logout


/lib/screens/seltzer_feed_screen.dart

/lib/main.dart

Problem: The button to logout is on the appBar of seltzer_feed_screen.dart. Whether or not a user is logged in is managed in main.dart. When I press the logout button, it's not redirecting me to the Auth screen. 



Require Unique Usernames

/lib/widgets/auth/auth_form.dart

Desired behavior: When a user signs up, validate the username they enter based on whether or not the username already exists in the database for another user

Problem: Validation function for username field isn't waiting for Async check of usernames in the database to complete, so even when there is a matching username in the database the validation function allows the input

## Done

Ability to search for other users

Ability to view other users' profiles
