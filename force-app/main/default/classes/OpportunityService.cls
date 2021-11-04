public with sharing class OpportunityService {

    public static void setOppValuesFromTasks(Map<Id,Task> newTasksMap, Map<Id,Task> oldTasksMap )
    {
        //TODO: if(Triggers.Stop)

        Set<Id> oppIds = new Set<Id>();

        for (Task t : newTasksMap.values()) 
        {
            if (t.Status     == Constants.TASK_STATUS_DONE
                && t.Status  !=  oldTasksMap.get(t.Id).Status
                && t.Subject == Constants.TASK_SUBJ_HIGH_VALUE //'Reduce Value'
                && t.WhatId.getSobjectType() == Schema.Opportunity.SObjectType)
            {
                oppIds.add(t.WhatId);
            }
        }
        
        Map<Id,Opportunity> oppsToUpdate = OpportunityAccessor.getOppAmounts(oppIds);

        for(Opportunity o : oppsToUpdate.values()) 
        {
            o.Amount *= Constants.DISCOUNT_RATE;
        }

        update oppsToUpdate.values();

    }
}
