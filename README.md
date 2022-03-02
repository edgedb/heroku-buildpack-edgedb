# Heroku Buildpack for EdgeDB
This is a [heroku buildpack](http://devcenter.heroku.com/articles/buildpacks)
that runs [EdgeDB](https://edgedb.com) in a dyno along with your application.
It is meant to be used [in conjunction with other
buildpacks](https://devcenter.heroku.com/articles/using-multiple-buildpacks-for-an-app).

This buildpack requires that the [Heroku
Postgres](https://elements.heroku.com/addons/heroku-postgresql) add-on is
enabled for your app.


## Usage

Run the following command in your project root.
```bash
heroku buildpacks:add --index 1 https://github.com/edgedb/heroku-buildpack-edgedb.git
```

Then prefix the relevant commands in your
[Procfile](https://devcenter.heroku.com/articles/procfile) with `start-edgedb`.

```
web: start-edgedb npm start-web
worker: start-edgedb npm start-worker
```

Note that you must prefix all commands that need access to EdgeDB with `start-edgedb`.
