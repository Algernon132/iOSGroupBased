# This is really just a place to hold thoughts so I don't forget right now. I'll flesh this out when more functionality is added.

* Passwords will be hashed with the SHA256 algorithm.
* This is pretty secure, it's definitely more than enough for this project
* All communication with this API will be done through JSON.
* In the JSON, there will be a value for the command to be run.
* The server will read that value and run the correct functions, making changes to the SQL and returning appropriate values
* Since all JSON will be created by the ios app before sending, I'm pretty much going to trust that all of the necessary values are there
* However, input will still be validated and errors will be handled gracefully.
