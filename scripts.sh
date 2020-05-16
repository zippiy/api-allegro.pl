
-- Simple product listing dump
curl -X GET  -H 'Accept: application/vnd.allegro.public.v1+json' -H "Authorization: Bearer $token" 'https://api.allegro.pl/offers/listing?phrase=majonez&category.id=73973&sort=+price&offset=0&limit=100' | jq '.items.regular | .[] | {id: .id, name: .name, price: .sellingMode.price.amount, seller: .seller.id}'

-- Simple category dump
curl -X GET -H "Authorization: Bearer $token" -H 'Accept: application/vnd.allegro.public.v1+json' 'https://api.allegro.pl/sale/categories?parent.id=258832' | jq

-- Number of offers
curl -X GET  -H 'Accept: application/vnd.allegro.public.v1+json' -H "Authorization: Bearer $token" 'https://api.allegro.pl/offers/listing?phrase=majonez&category.id=73973&sort=+price&offset=0&limit=100' | jq '.filters[0].values[0] | .'
