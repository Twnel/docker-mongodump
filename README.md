# docker-mongodump

Docker image with mongodump running as a cron task

## Getting Started

Make sure the prerequisites are followed, and the container will be able to run standalone.

### Prerequisites

Docker

```
curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh
```

MongoDB

```
docker run 27017:27017 mongo
```

### Installing

Build the app container image locally:

```
docker build --rm=false -t twnel/<my_image_name> .
```

## Running the tests

```
docker exec -ti twnel/<my_image_name> bash -c 'sh backup.sh'
```

## Deployment

Attach a target mongo container to this container and mount a volume to container's `/data` folder. Backups will appear in this volume. Optionally set up cron job schedule (default is `0 1 * * *` - runs every day at 1:00 am).

    docker run -d \
        -v /path/to/target/folder:/backup \ # where to put backups
        -e 'CRON_SCHEDULE=0 1 * * *' \      # cron job schedule
        --link my-mongo-container:mongo \   # linked container with running mongo
        twnel/<my_image_name>

To run backup once without cron job, add `no-cron` parameter:

    docker run --rm \
        -v /path/to/target/folder:/backup \ # where to put backups
        --link my-mongo-container:mongo \   # linked container with running mongo
        twnel/<my_image_name>

## Built With

* [SH](http://man.openbsd.org/sh)

## Contributing

1. Create isolated branches for development.
2. Commit your changes, rebase locally from dev/beta branch and create pull requests for the dev/beta branch.
3. Squash merge when approved and delete the alternate remote branch.
4. Rebase the alternate branch locally.
5. Pull requests to higher branches will be done merging the commits, no squash or rebase merge will be done.

## Versioning

For the versions available, see the [tags on this repository](https://github.com/Twnel/docker-mongoui/tags). 

## Authors

* **Ericson Cepeda** - *Initial work* - [ericson-cepeda](https://github.com/ericson-cepeda)

See also the list of [contributors](https://github.com/Twnel/docker-mongoui/contributors) who participated in this project.

## License

MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* This project contains modifications for Twnel specific requirements.
