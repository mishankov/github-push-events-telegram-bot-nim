from os import getEnv
import strutils

const
  TELEGRAM_BOT_TOKEN* = getEnv("TELEGRAM_BOT_TOKEN", "is not set")
  TELEGRAM_CHAT_ID* = parseUInt(getEnv("TELEGRAM_CHAT_ID", "0"))

  GITHUB_WEBHOOK_SECRET* = getEnv("GITHUB_WEBHOOK_SECRET", "secret")
