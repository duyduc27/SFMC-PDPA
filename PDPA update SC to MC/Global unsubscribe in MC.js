<script runat="server">

Platform.Load("core","1.1.1");

function logUnsubEvent(mid, SubscriberKey, EmailAddress, JobID, Reason) {

    var prox = new Script.Util.WSProxy();
    prox.setClientId({"ID": mid});

    var props = [];

    props.push({ Name: "SubscriberKey", Value: SubscriberKey });
    props.push({ Name: "EmailAddress", Value: EmailAddress });

    if (JobID && JobID != '') {
      props.push({ Name: "JobID", Value: JobID });
    }

    /*
    if (ListID && ListID != '') {
      props.push({ Name: "ListID", Value: ListID });
    }

    if (BatchID && BatchID != '') {
      props.push({ Name: "BatchID", Value: BatchID });
    }
    */

    props.push({ Name: "Reason", Value: Reason});

    try {

          if (SubscriberKey && SubscriberKey != "") {

            var response = prox.execute(props, "LogUnsubEvent");

            if (debug) {
               Write("<br><br>props: " + Stringify(props));
               Write("<br>response: " + Stringify(response));
               Write("<br>response.Results[0].StatusCode: " + response.Results[0].StatusCode);
               Write("<br>response.Results[0].ErrorCode: " + response.Results[0].ErrorCode);
               Write("<br>response.Results[0].StatusMessage: " + response.Results[0].StatusMessage);
            }

            var result = ((response.Results[0].ErrorCode == "0" && response.Results[0].StatusMessage == "Event posted") || (response.Results[0].ErrorCode == "12012" && response.Results[0].StatusMessage == "OnMasterUnsubscribeList") || (response.Results[0].ErrorCode == "401" && response.Results[0].StatusMessage == "Subscriber is already unsubscribed")) ? ["OK"] : ["Error"];

            return result[0];
          }

    } catch (e) {

      writeLog("Exception", Stringify(e));

    }


  }

var myDEName = "PDPA temporary SC false MC sub";
var data = Platform.Function.LookupRows(myDEName, 'Remark', 'Aodigy unsub');
if (data.length > 0) {
        for (var i = 0; i < data.length; i++)
        {
            var SubscriberKey = data[i].SubscriberKey;
            var mid = '100014836'; /* dev mid*/
            var EmailAddress = data[i].EmailAddress;
            var Reason = 'Unsubscribed from Sales Cloud';
            var JobID = ''; /* id of email, I chose blank value to global unsubscribe */
            logUnsubEvent(mid, SubscriberKey, EmailAddress, JobID, Reason);
        };
    };
</script>
