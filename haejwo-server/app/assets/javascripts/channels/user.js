jQuery(function() {
  const current_user_id = $('body').data("user-id");
  if (current_user_id !== void 0 && current_user_id !== "") {
    return App.user = App.cable.subscriptions.create({
      channel: "UserChannel",
      user_id: current_user_id
    },
    {
      connected: function() {
        console.log(`user_${current_user_id}_channel connected`);

      },

      disconnected: function() {},

      received: function(data) {
        if (data.broad_type === 'message') {
          var messages = app.messages.create({
            el: '.messages',
            // First message rule
            firstMessageRule: function (message, previousMessage, nextMessage) {
              if (message.isTitle) return false;
              if (!previousMessage || previousMessage.type !== message.type || previousMessage.name !== message.name) return true;
              return false;
            },
            // Last message rule
            lastMessageRule: function (message, previousMessage, nextMessage) {
              if (message.isTitle) return false;
              if (!nextMessage || nextMessage.type !== message.type || nextMessage.name !== message.name) return true;
              return false;
            },
            // Last message rule
            tailMessageRule: function (message, previousMessage, nextMessage) {
              if (message.isTitle) return false;
              if (!nextMessage || nextMessage.type !== message.type || nextMessage.name !== message.name) return true;
              return false;
            }
          });

          messages.addMessage({
            text: data.message_content,
            type: 'received',
            name: data.username,
            avatar: data.thumbnail
          });
        }
      }
    });
  };
});
