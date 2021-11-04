public with sharing class TaskService 
{
    public TaskService() 
    {

    }

    /**************************************************************
    *   Creates a task associated with any Sobject
    *   to follow up in 10 days time 
    *   Called in the context of an after insert trigger
    ***************************************************************/

    public static void addFollowUpTask(Map<Id,sObject> sobjMap)
    {
        List<Task> newFollowUpTasks = new List<Task>();

        for (sObject obj : sobjMap.values()) 
        {
            Task newTask      = new Task();
            newTask.WhatId    = obj.Id;
            newTask.OwnerId   = System.UserInfo.getUserId();
            newTask.Status    = Constants.TASK_STATUS_NEW;
            newTask.Subject   = Constants.TASK_SUBJ_NORMAL;
            newTask.ActivityDate = System.today().addDays(Constants.DAYS_DUE_NORMAL);
            newFollowUpTasks.add(newTask);

            //high-value Opportunity
            if( obj instanceof Opportunity)
            {
                Decimal oppAmount = (Decimal) obj.get('Amount');
                Boolean isHighValueOpp = oppAmount > Constants.OPP_HIGH_VALUE_THRESHOLD;

                if(isHighValueOpp)
                {
                    Task hvoTask = newTask.clone();
                    hvoTask.Subject   =  Constants.TASK_SUBJ_HIGH_VALUE ;
                    hvoTask.ActivityDate = System.today().addDays(Constants.DAYS_DUE_HIGH_VALUE);
                    newFollowUpTasks.add(hvoTask);
                }
            }
        }

        if (!newFollowUpTasks.isEmpty()) 
        {
            insert newFollowUpTasks;
        }
    }


}
