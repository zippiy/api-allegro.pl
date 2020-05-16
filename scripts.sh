## Env variables to be set accordingly
export auth=
export client_id=
export device_code=
export device_token=

1. 
## Auth Device == User context/app. %auth is base64 encoded client id : client secret according to Allegro API spec
## Save output as $device_code
curl -X POST 'https://allegro.pl/auth/oauth/device' -H "Authorization: Basic $auth" -H 'Content-Type: application/x-www-form-urlencoded' -d 'client_id=$client_id'

## get token for given device and user. Call to obtain new auth or use refresh token
## Save output as $device_token
curl -X POST "https://allegro.pl/auth/oauth/token?grant_type=urn%3Aietf%3Aparams%3Aoauth%3Agrant-type%3Adevice_code&device_code=$device_code" -H "Authorization: Basic $auth"

2.
## Simple product listing dump as JSON
curl -X GET  -H 'Accept: application/vnd.allegro.public.v1+json' -H "Authorization: Bearer $token" 'https://api.allegro.pl/offers/listing?phrase=majonez&category.id=73973&sort=+price&offset=0&limit=100' | jq '.items.regular | .[] | {id: .id, name: .name, price: .sellingMode.price.amount, seller: .seller.id}'
## as CSV
curl -X GET  -H 'Accept: application/vnd.allegro.public.v1+json' -H "Authorization: Bearer $token" 'https://api.allegro.pl/offers/listing?phrase=majonez&category.id=73973&sort=+price&offset=0&limit=50' | jq '.items.regular | .[] | .id + ", " + .name + ", " + .sellingMode.price.amount + ", "+ .seller.id'

## Promoted and regular items merged together as CSV
curl -X GET  -H 'Accept: application/vnd.allegro.public.v1+json' -H "Authorization: Bearer $token" 'https://api.allegro.pl/offers/listing?phrase=majonez&category.id=73973&sort=+price&offset=0&limit=50' | jq '.items | select(.regular or .promoted) | .[] | .[] | .id + ", " + .name + ", " + .sellingMode.price.amount + ", "+ .seller.id'

## Number of offers
curl -X GET  -H 'Accept: application/vnd.allegro.public.v1+json' -H "Authorization: Bearer $token" 'https://api.allegro.pl/offers/listing?phrase=majonez&category.id=73973&sort=+price&offset=0&limit=100' | jq '.filters[0].values[0] | .'

## Quotes in csv removed
curl -X GET  -H "Accept: application/vnd.allegro.public.v1+json" -H "Authorization: Bearer $token" "https://api.allegro.pl/offers/listing?phrase=majonez&category.id=73973&sort=+price&offset=$offset&limit=50" | jq -r '.items | select(.regular or .promoted) | .[] | .[] | .id + ", " + .name + ", " + .sellingMode.price.amount + ", "+ .seller.id'

## Column values escaped 
curl -X GET  -H "Accept: application/vnd.allegro.public.v1+json" -H "Authorization: Bearer $token" "https://api.allegro.pl/offers/listing?phrase=majonez&category.id=73973&sort=+price&offset=$offset&limit=50" | jq -r '.items | select(.regular or .promoted) | .[] | .[] | [.id, .name, .sellingMode.price.amount, .seller.id] | @csv'

3.
## Simple category dump
curl -X GET -H "Authorization: Bearer $token" -H 'Accept: application/vnd.allegro.public.v1+json' 'https://api.allegro.pl/sale/categories?parent.id=258832' | jq

4.
## Not public API, user context is needed
curl -X GET 'https://api.allegro.pl/sale/products?phrase=majonez' -H "Authorization: Bearer $device_token" -H 'Accept: application/vnd.allegro.public.v1+json' -H 'content-type: application/vnd.allegro.public.v1+json'  

5.
## url & seller.id link
wget https://allegro.pl/uzytkownik/10787036/oceny
