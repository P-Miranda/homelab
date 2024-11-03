# Radicale
Notes about [Radicale](https://radicale.org/v3.html), a CalDAV + CardDAV
server.

This server is used to manage calendars and contacts.

Currently using the
[docker-radicale](https://github.com/cupcakearmy/docker-radicale) repository
for a docker deployment.

## User authentication:
Create a `./data/users` file with each user in a line in the format:
   `user:[bcrypt_passwd]`
NOTE: you can get the bcrypt value from this command:
```
# Install with command:
# sudo apt update; sudo apt install apache2-utils
htpasswd -bnBC 10 "" PASSWORD | tr -d ':\n' | sed 's/$2y/$2a/'
```
NOTE: bcrypt hashes are different each time due to random salt.

# Clients
- Desktop: use thunderbird
- Android: DAVx5 + simple calendar?
