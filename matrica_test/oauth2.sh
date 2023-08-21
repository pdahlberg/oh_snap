#!/bin/bash

CLIENT_ID="bba650d310b2880"
SCOPE="profile"
REDIRECT_URI="https%3A%2F%2Fapp.ohsnap.app%2Fauth%2Fcallback"
CODE_CHALLENGE="rnzVTnBrGBX2ylAe8whORYURbhRtcuTsKR-ThLAuFIQ"
STATE="x1561axa165"

echo "https://matrica.io/oauth2?client_id=$CLIENT_ID&scope=$SCOPE&response_type=code&redirect_uri=$REDIRECT_URI&code_challenge=$CODE_CHALLENGE&code_challenge_method=S256&state=$STATE"


# https://app.ohsnap.app/auth/callback
# ? code=U2FsdGVkX1%2BQcqsFTSw%2BfkVHbersgJEmaGIoi9tbqUgCXB3x5yp1n%2FKRA1EfhkxR7zqVAqtLp6wiCwkCrFxCkPci%2F8gmTWKKn9saXol%2FUXH%2BdYrwXl267MhV2VcRAJGilEJi%2F4MIib0nv19zdsxvL2kEg9PAhSUxVBJfuqh%2Fq7moowp%2FVzSigQxrkTg%2ByxfVAslDAI62UGpqFg8QVU4Cq3dXGXK9Pv1dX%2FLIinRkWp2CPr5WM43KfWUv3NGh7nMAwwbmwt1g%2BvVixBTnRMmN3IT3xgQIo6uGrga3tEsOxT7ooSE%2FHgU%2FePybGc6894zif2VHZHmU1f%2FaYPAF2zT6zA%3D%3D
# & state=x1561axa165