trigger CountContactTrigger on Contact (after insert,after delete) {
    System.TriggerOperation triggerEvent = trigger.operationType;
    switch on triggerEvent {
        when AFTER_INSERT {
            countContactHandler.OnAfterInsert(trigger.new,trigger.oldmap);
        }
        when AFTER_DELETE {
            countContactHandler.OnAfterDelete(trigger.old,trigger.oldmap);
        }
    }
}