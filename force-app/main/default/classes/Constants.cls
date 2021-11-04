public with sharing class Constants 
{
    public static final Integer OPP_HIGH_VALUE_THRESHOLD = 50000; //Candidate to reduce value
    public static final String TASK_SUBJ_HIGH_VALUE = 'Reduce Value';
    public static final String TASK_SUBJ_NORMAL = 'Follow Up';
    public static final Integer DAYS_DUE_HIGH_VALUE = 2;
    public static final Integer DAYS_DUE_NORMAL = 10;
    public static final String TASK_STATUS_NEW = 'New';
    public static final String TASK_STATUS_DONE = 'Completed';
    public static final Double DISCOUNT_RATE = 0.5;


    /*
        Private because it only contains static "constants", 
        there's no value to allowing it to be instantiated
    */
    private Constants() {

    }
}
