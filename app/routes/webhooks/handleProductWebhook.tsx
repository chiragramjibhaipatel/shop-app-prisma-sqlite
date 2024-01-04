import logger from "../../../logger";
import db from "~/db.server";


export function handleProductCreateWebhook({webhookRequestId, topic, shop, admin, payload}: {
  webhookRequestId: String;
  topic: String;
  shop: String;
  admin: any;
  payload: any;
}) {
  logger.info({webhookRequestId, msg: "Inside handleProductCreateWebhook"});
  handleProductWebhook({webhookRequestId, topic, shop, admin, payload});
}

export function handleProductUpdateWebhook({webhookRequestId, topic, shop, admin, payload}: {
  webhookRequestId: String;
  topic: String;
  shop: String;
  admin: any;
  payload: any;
}) {
  logger.info({webhookRequestId, msg: "Inside handleProductUpdateWebhook"});
  handleProductWebhook({webhookRequestId, topic, shop, admin, payload});

}

export async function handleProductDeleteWebhook({webhookRequestId, topic, shop, admin, payload}: {
  webhookRequestId: String;
  topic: String;
  shop: String;
  admin: any;
  payload: any;
}) {
  logger.info({webhookRequestId, msg: "Inside handleProductDeleteWebhook"});
  logger.debug({webhookRequestId, payload, msg: "handleProductDeleteWebhook"});
  await db.product.delete({where: {id: payload.id}});
}

async function handleProductWebhook({webhookRequestId, topic, shop, admin, payload}: {
  webhookRequestId: String;
  topic: String;
  shop: String;
  admin: any;
  payload: any;
}) {
  const {image, images, options, variants, ...product} = payload;
  // logger.info({webhookRequestId, product, images, options, variants,  msg: "handleProductWebhook"})

  const productCreated = await db.product.upsert({where: {id: product.id}, create: product, update: {...product}});

  for (const variant of variants) {
    await db.variant.upsert({where: {id: variant.id}, create: variant, update: variant});
  }

  for (const image of images) {
    await db.image.upsert({where: {id: image.id}, create: {...image, variant_ids: image.variant_ids.join()}, update: {...image, variant_ids: image.variant_ids.join()}});
  }

  logger.info({webhookRequestId, topic, shop, status: "success", msg: "handleProductWebhook"})
}
 
