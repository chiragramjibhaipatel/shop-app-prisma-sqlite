import logger from "../../../logger";

export function handleProductWebhook({webhookRequestId, topic, shop, admin, payload}: {
  webhookRequestId: String;
  topic: String;
  shop: String;
  admin: any;
  payload: any;
}) {
  logger.info({webhookRequestId, msg:"Inside handleProductWebhook"})
  const {image, images, options, variants, ...product} = payload;
  logger.info({webhookRequestId, topic, shop})
}
