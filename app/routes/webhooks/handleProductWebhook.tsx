export function handleProductWebhook({topic, shop, admin, payload}: {
  topic: String;
  shop: String;
  admin: any;
  payload: any;
}) {
  console.log("Inside handleProductWebhook")
  const {image, images, options, variants, ...product} = payload;
  console.log({image, images, options, variants, product})
}
