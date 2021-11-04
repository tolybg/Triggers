public with sharing class OpportunityService {

    public static void setOppValuesFromTasks(Map<Id,Task> newTasksMap, Map<Id,Task> oldTasksMap )
    {
        //TODO: if(Triggers.Stop)

        Set<Id> oppIds = new Set<Id>();

        for (Task task : newTasksMap.values()) 
        {
            if (task.Status     == Constants.TASK_STATUS_DONE
                && task.Status  !=  oldTasksMap.get(task.Id).Status
                && task.Subject == Constants.TASK_SUBJ_HIGH_VALUE //'Reduce Value'
                && task.WhatId.getSobjectType() == Schema.Opportunity.SObjectType)
            {
                oppIds.add(task.WhatId);
            }
        }
        
        List<Opportunity> oppsToUpdate = OpportunityAccessor.getOppAmounts(oppIds);

        for(Opportunity opp : oppsToUpdate) 
        {
            opp.Amount *= Constants.DISCOUNT_RATE;
        }

        update oppsToUpdate;

    }
}
