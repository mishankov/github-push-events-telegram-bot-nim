import jester, json, options, strutils

from config import GITHUB_WEBHOOK_SECRET
import telegram/bot
import telegram/utils

import github/models/payload

# operators overload just to try this feature
proc `+`(s1: string, s2: string): string = 
  s1 & s2

proc `+=`(s1: var string, s2: string) = 
  s1 = s1 + s2

routes:
  get "/":
    resp %*{"status": "OK"}

  post "/github/repository/webhook/@secret":
    cond @"secret" == config.GITHUB_WEBHOOK_SECRET

    let payloadJson = parseJson(request.body)
    let payload = to(payloadJson, Payload)
    let bot = Bot(token: config.TELEGRAM_BOT_TOKEN)

    var message = "New push in repository <a href='" + payload.sender.get().html_url.get() + "'>" + escapeHtml(payload.repository.get().full_name.get()) + "</a>"
    if payload.commits.isSome() and len(payload.commits.get()) > 0:
      message += "\n<b>Commits:</b>"

    if payload.sender.isSome():
      message += " from <a href='" & payload.sender.get().html_url.get() & "'>" & escapeHtml(payload.sender.get().login.get()) & "</a>"

    for commit in payload.commits.get():
      message += "\n<a href='" + commit.url.get() + "'>" + escapeHtml(commit.id.get()) + "</a>"
      message += "\n  <i>Message:</i> " + escapeHtml(commit.message.get()) 

      if commit.added.isSome() and len(commit.added.get()) > 0:
        message += "\n  <i>Added:</i> " + escapeHtml(join(commit.added.get(), ", "))

      if commit.removed.isSome() and len(commit.removed.get()) > 0:
        message += "\n  <i>Removed:</i> " + escapeHtml(join(commit.removed.get(), ", "))

      if commit.modified.isSome() and len(commit.modified.get()) > 0:
        message += "\n  <i>Modified:</i> " + escapeHtml(join(commit.modified.get(), ", "))


      discard bot.sendMessage(chatId = config.TELEGRAM_CHAT_ID, parseMode = "HTML", text = message)    
    
    resp %*{"status": "OK"}

  post "/github/repository/webhook/@secret":
    resp %*{"status": "wrong secret"}
