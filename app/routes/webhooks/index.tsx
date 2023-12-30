import type {ActionFunctionArgs} from "@remix-run/node";
import {v4 as uuidv4} from "uuid";
import {authenticate} from "../../shopify.server";
import db from "../../db.server";
import {handleProductCreateWebhook, handleProductUpdateWebhook,handleProductDeleteWebhook} from "~/routes/webhooks/handleProductWebhook";
import logger from "../../../logger";

export const action = async ({request}: ActionFunctionArgs) => {
  const {topic, shop, session, admin, payload} = await authenticate.webhook(
    request
  );
  const webhookRequestId = uuidv4();
  logger.debug({webhookRequestId, topic})

  if (!admin) {
    // The admin context isn't returned if the webhook fired after a shop was uninstalled.
    throw new Response();
  }

  switch (topic) {
    case "APP_UNINSTALLED":
      if (session) {
        await db.session.deleteMany({where: {shop}});
      }

      break;
    case "PRODUCTS_CREATE":
      handleProductCreateWebhook({webhookRequestId, topic, shop, admin, payload});
      break
    case "PRODUCTS_UPDATE":
      handleProductUpdateWebhook({webhookRequestId, topic, shop, admin, payload});
      break
    case "PRODUCTS_DELETE":
      handleProductDeleteWebhook({webhookRequestId, topic, shop, admin, payload});
      break
    case "CUSTOMERS_DATA_REQUEST":
    case "CUSTOMERS_REDACT":
    case "SHOP_REDACT":
    default:
      throw new Response("Unhandled webhook topic", {status: 404});
  }

  throw new Response();
};

