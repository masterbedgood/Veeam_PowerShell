#Requires -PSSnapin veeampssnapin

function Get-VeeamFullBackupSchedule
{

    param(
        [string[]]$JobName
    )

    $JobHash = @{}
    if($JobName){$JobHash.Name = $JobName}

    Get-VBRJob @JobHash | %{

        $Job = $_

        $JobOptions = Get-VBRJobOptions $Job

        $JobScheduleOptions = $JobOptions.BackupTargetOptions.FullBackupMonthlyScheduleOptions

        New-Object PSObject -Property @{
            DayOfWeek = $JobScheduleOptions.DayOfWeek
            DayNumberInMonth = $JobScheduleOptions.DayNumberInMonth
            DayOfMonth = $JobScheduleOptions.DayOfMonth
            Months = $JobScheduleOptions.Months
            JobName = $Job.Name
        } | Select JobName,DayOfWeek,DayNumberInMonth,DayOfMonth,Months
    }
}
