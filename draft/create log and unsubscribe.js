<script runat="server" type="text/javascript">
Platform.Load("core", "1");
var unsubDE = DataExtension.Init("PDPA temporary DE");
var data = unsubDE.Rows.Retrieve();
var logging = [];
if(data.length > 0) {
        for (var i = 0; i < data.length; i++)
        {
            var SubId = data[i].SubscriberKey;
                try {   
                    var subObj = Subscriber.Init(SubId);
                    var status = subObj.Unsubscribe();
                } 
                catch (e) {
                    var status = "error";
                    var output = logging.push({SubscriberKey: SubId, EmailAddress: data[i].EmailAddress, Email_Status: data[i].Email_Status, Status: 'Error Processing Optout', Timestamp: Date.now()});
                }
            if (status != "error") {      
            var output = logging.push({SubscriberKey: SubId, EmailAddress: data[i].EmailAddress, Email_Status: data[i].Email_Status, Status: 'Unsubscribe Complete', Timestamp: Date.now()});
            }
        };
        var loggingDE = DataExtension.Init("LoggingDataExtension process");
        loggingDE.Rows.Add(logging);
    };
</script>