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

## Todos
- Probably change QueryService to be a bunch of extensions on session or session.db.
