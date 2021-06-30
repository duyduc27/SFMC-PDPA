<script runat="server">

Platform.Load("core","1.1.1");

var myDEName = "PDPA temporary SC true MC unsub";
var data = Platform.Function.LookupRows(myDEName, 'Remark', 'Aodigy sub');
if (data.length > 0) {
        for (var i = 0; i < data.length; i++)
        {
          var subscriber = {"Status": "Active"};
          var subObj = Subscriber.Init(data[i].SubscriberKey);
          var status = subObj.Update(subscriber);
        };
    };
</script>
