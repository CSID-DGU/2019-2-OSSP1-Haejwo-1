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
        console.log(data);

        if (data.broad_type === 'message') {
          
        }

      }
    });
  };
});
