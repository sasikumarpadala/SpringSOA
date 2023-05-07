({
    doInit : function(component, event, helper) {
        var action = component.get("c.getRecentAccounts");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.accounts", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },
     doRedirect: function(component, event, helper) {
    //console.log('doRedirect function called');
    var eventSource = event.getSource();
    //console.log(eventSource);
    var Id = eventSource.get("v.name");
    //alert(Id);
    var navEvt = $A.get("e.force:navigateToSObject");
    navEvt.setParams({
      'recordId': Id,
      'slideDevName': "detail",
    });
    navEvt.fire();
  }
})
