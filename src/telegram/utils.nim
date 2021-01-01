import strutils

proc escapeHtml*(text: string): string = 
  text.replace("&", "&amp").replace("<", "&lt").replace(">", "&gt")
