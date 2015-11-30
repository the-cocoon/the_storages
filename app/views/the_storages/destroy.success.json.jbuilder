json.set! :keep_alerts, true

json.set! :html_content, {
  destroy: [ "li[data-node-id='#{ @attachment.id }']"]
}

json.set! :flash, {
  notice: "Файл удален"
}