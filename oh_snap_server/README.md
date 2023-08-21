# Oh Snap

## Goals
- Explore [Serverpod](https://serverpod.dev/) end-to-end.
- Create an [OPOS hackaton](https://www.oposhackathon.com/) project.
- Exploring [Solana](https://solana.com/) cNFT:s, well at least a little bit. 

## Notes
- Quite tricky to formulate a proper architecture with Serverpod.
- Paying for the requests needs to be done in a somewhat transparent way to solve for Google Play publish. 
  - Credits added outside the app seems to be the way.
  - Would be nice for one credit to pay for one request, but not great as internal representation with many different steps to pay for.

## Serverpod
- Task.find() and Post.find() doesn't work even though they are generated.
- Annoying to have enums be integers in the database. 
- Not sure what I think about using the DB for logs.
  - The one good reason to do that would probably be to be able to reference other db entities. 
- The build in query builder doesn't seem to work. 
- Select statements seems to have their columns forced to lowercase which makes generated tables in combination with manual queries quite annoying. 
- For now... not at all production ready on the server side. Having to build way too many primitive things myself.
- Columns seems to be forced to lower case, which in turn breaks it's own queries.
- Updating passwords in the passwords.yaml file doesn't seem to propogate to the server unless one deletes the full serverpod directory from the EC2 instance.

## Todos
- Probably change QueryService to be a bunch of extensions on session or session.db.
- Would be nice to use [Gum](https://twitter.com/gumisfunn) profiles.
