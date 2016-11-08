# Turma da Mônica Jovem - API

1. [Cards](#cards)

## API Methods

### Cards

#### List
* Endpoint: /api/cards.json OR /api/cards/(:page)/(:quantity).json
* Method: [GET]

_response:_

```json
{
  "cards": [
    {
      "id": 1,
      "origin": "twitter",
      "content": "RT @blackcanaryw: Fui pro chão!! 💔 #Doconica #TurmaDaMonicaJovem #TMJ https://t.co/1T0msg5Z7k",
      "kind": "image",
      "user": {
        "id": 1,
        "name": "Adão Raul",
        "avatar": "http://localhost:3000//uploads/image/file/1/CpJ3csIWEAAQegg.jpg"
      },
      "image": {
        "url": "http://localhost:3000//uploads/image/file/1/CpJ3csIWEAAQegg.jpg",
        "ratio": "0,913"
      },
      "posted_at": "2016-09-15T19:24:00.000Z"
    }
  ]
}
```
