# About Devbelt
Devbelt is a collection of easily configured Docker containers for DevOps. Hosting your own project management solution shouldn't take more time / money than the project itself! This Docker network uses [Gitea](https://github.com/go-gitea/gitea) for code versioning and [Lean Time](https://github.com/Leantime/leantime) for project management.

## Running Devbelt
Devbelt is easy to get started...

1. Clone the repo
```sudo git clone```
1. Enter the working directory ```cd devbelt```
1. Copy the sample.env file
```sudo cp sample.env .env```
1. Change the desired settings in the ```.env``` file.
1. Copy Gitea config ```sudo cp gitea/sample.gitea.ini gitea/gitea.ini```
1. Edit Gitea config file ```vi gitea/gitea.ini``` with the desired settings for your application
1. Copy Leantime sample config ```sudo cp leantime/sample.env leantime/.env```
1. Edit Leantime settings according to your needs ```vi leantime/.env```
1. Copy systemd service to desired location (i.e. ```cp docker-compose@.service /etc/systemd/system/docker-compose@.service```)
1. Start the systemd service