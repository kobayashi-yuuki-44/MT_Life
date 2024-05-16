# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "toggle_memo", to: "toggle_memo.js"
pin "card", to: "card.js"
pin "notebook", to: "notebook.js"
pin "add_page", to: "add_page.js"
pin "@rails/actioncable", to: "actioncable.esm.js"
pin_all_from "app/javascript/channels", under: "channels"
pin "consumer", to: "channels/consumer.js"
pin "room_channel", to: "channels/room_channel.js"