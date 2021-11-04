public with sharing class TaskService 
{
    public TaskService() 
    {

    }

    /**************************************************************
    *   Creates a task associated with the opportunity 
    *   to follow up in 10 days time 
    *   Called in the context of an after insert trigger
    ***************************************************************/

    public static void addFollowUpTask(Map<Id,Opportunity> oppMap)
    {
        //TODO: if(!Triggers.Stop) 

        List<Task> newFollowUpTasks = new List<Task>();

        for (Opportunity o : oppMap.values()) 
        {
            //TODO: if(o.StageName = 'Prospecting') //Ask KAB???

            Task t      = new Task();
            t.WhatId    = o.Id;
            t.OwnerId   = System.UserInfo.getUserId();
            t.Status    = Constants.TASK_STATUS_NEW;
            t.Subject   = Constants.TASK_SUBJ_NORMAL;
            t.ActivityDate = System.today().addDays(Constants.DAYS_DUE_NORMAL);
            newFollowUpTasks.add(t);

            //high-value tasks
            if(o.Amount > Constants.OPP_HIGH_VALUE_THRESHOLD)
            {
                Task t2 = t.clone();
                t2.Subject   =  Constants.TASK_SUBJ_HIGH_VALUE ;
                t2.ActivityDate = System.today().addDays(Constants.DAYS_DUE_HIGH_VALUE);
                newFollowUpTasks.add(t2);
            }
        }

        if (!newFollowUpTasks.isEmpty()) 
        {
            insert newFollowUpTasks;
        }
    }


}
