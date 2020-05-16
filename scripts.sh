
-- Simple dump
curl -X GET  -H 'Accept: application/vnd.allegro.public.v1+json' -H "Authorization: Bearer $token" 'https://api.allegro.pl/offers/listing?phrase=majonez&category.id=73973&sort=+price&offset=0&limit=100' | jq '.items.regular | .[] | {id: .id, name: .name, price: .sellingMode.price.amount, seller: .seller.id}'

-- Number of offers
curl -X GET  -H 'Accept: application/vnd.allegro.public.v1+json' -H "Authorization: Bearer $token" 'https://api.allegro.pl/offers/listing?phrase=majonez&category.id=73973&sort=+price&offset=0&limit=100' | jq '.filters[0].values[0] | .'
