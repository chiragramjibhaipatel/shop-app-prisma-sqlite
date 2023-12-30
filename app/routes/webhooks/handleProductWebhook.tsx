import logger from "../../../logger";
import db from "~/db.server";


export function handleProductCreateWebhook({webhookRequestId, topic, shop, admin, payload}: {
  webhookRequestId: String;
  topic: String;
  shop: String;
  admin: any;
  payload: any;
}) {
  logger.info({webhookRequestId, msg:"Inside handleProductCreateWebhook"});
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
  logger.debug({webhookRequestId, product, msg:"handleProductWebhook"})
  await db.product.upsert({where:{id: product.id}, create: product, update: product})
  logger.info({webhookRequestId, topic, shop, status: "success", msg:"handleProductWebhook"})
}
