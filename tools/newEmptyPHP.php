<?php

class actions_sendemail_recentdowntime3test {

  function handle(&$params) {

    echo "<br><h2>Email send process -- recent downtime...</h2><br>";

// give it some time to send the email. i think set_time_limit(30) is default. May need 60 sec. 2013-11-15,2015-03-26
// http://php.net/manual/en/function.set-time-limit.php
    set_time_limit(130);

// cron tips...
// https://groups.google.com/forum/#!searchin/xataface/cron%7Csort:relevance/xataface/JvLOLWEtgHU/t5pBa6AjwEcJ
// 
//$auth = & Dataface_AuthenticationTool::getInstance(); // reference to Dataface_Authentication object
//$user = & $auth->getLoggedInUser();  // Dataface_Record object of currently logged in user.
    $user = new Dataface_Record('users', array('role' => 'READ ONLY', 'username' => 'read'));
//$_SESSION['UserName'] = 'read';
    $auth = & Dataface_AuthenticationTool::getInstance(); // reference to Dataface_Authentication object
    $user = & $auth->getLoggedInUser();  // Dataface_Record object of currently logged in user.
    $app = & Dataface_Application::getInstance();  // reference to Dataface_Application object
//Dataface_PermissionsTool::ALL();
//$user = 'coop';
//$pass = '99815cf6ff4a7effd8fd27ca3b912d6e';
//no need to get the current query...
//$query =& $app->getQuery();
//These queries are hard coded to the downtime table, so this error check may be redundant.
//if ( $query['-table'] != 'pr_downtime1' ){
//    return PEAR::raiseError('This action can only be called on the True North List table.');
//}
//$to1      = 'stratford.reports@stackpole.com'; // in the final version only this one is needed
//$to1      = 'jmcmaster@stackpole.com,dmilne@stackpole.com,gpackham@stackpole.com,rmillion@stackpole.com,dclark@stackpole.com,kedwards@stackpole.com,fponte@stackpole.com,smcmahon@stackpole.com,jsegeren@stackpole.com,bsproat@stackpole.com,ttobey@stackpole.com,dgleba@stackpole.com'; // Just modified for now per Tim Tobey's request.  He wasn't in original
//$to1      = 'dclark@stackpole.com'; // Test with this one
    $to1 = 'dgleba@stackpole.com'; // fill in your own email here for testing purposes
    $subject1 = 'test3 -b-  Recent Downtime Report (from "Prodigy" App)';
    $headers1 = "From: " . "stratford.reports@stackpole.com" . "\r\n";
//$headers1 .= "bcc: " . "dgleba@stackpole.com" . "\r\n";
    $headers1 .= "Reply-To: " . "Do-not-reply-here" . "\r\n";
    $headers1 .= "MIME-Version: 1.0\r\n";
    $headers1 .= "Content-Type: text/html; charset=ISO-8859-1\r\n";

    $message1 = '<html><body>';
    $message1 .= 'Open downtime items from the Production/Downtime Status App. <br>';
    $message1 .= 'The open items have no completed-time.<br><br>';

//first table..................................
//'Query' Method
//$query['-table'] = 'pr_downtime1';
//$query['-search'] = 'draw';
//$query['called4helptime'] = '>=3/26/2015';
//$query['closed'] = '!= 1';
//$query['-limit'] = 20;
//$list1 = df_get_records_array('pr_downtime1', $query); 
//
//'Array' method:
    $list1 = df_get_records_array('pr_downtime1', array('closed' => "!=1", '-limit' => '30'));
//an example... $list1 = df_get_records_array('pr_downtime1', array('called4helptime'=>">=2/20/2015 AND <=3/28/2015", '-limit'=>'30')); 

    $message1 .= '<table cellpadding="5" cellspacing="0" border="1" bgcolor="#FFFFFF" style="background: #FEE5DF">';
    $message1 .= '<tr><th>Called 4 help time</th>';
    $message1 .= '<th>Machine</th>';
    $message1 .= '<th>Problem</th>';
    $message1 .= '<th>Down</th>';
    $message1 .= '<th>Who Is On It</th>';
    $message1 .= '<th>Completed Time</th>';
    $message1 .= '<th>Remedy</th></tr>';

    foreach ($list1 as $arecord) {
      $message1 .= '<tr><td style="background: #FFFFC2">' . $arecord->htmlValue('called4helptime') . '</td>';
      $message1 .= '<td style="background: #FFFFC2">' . $arecord->htmlValue('machinenum') . '</td>';
      $message1 .= '<td style="background: #FFFFC2">' . $arecord->htmlValue('problem') . '</td>';
      $message1 .= '<td style="background: #FFFFC2">' . $arecord->htmlValue('down') . '</td>';
      $message1 .= '<td style="background: #FFFFC2">' . $arecord->htmlValue('whoisonit') . '</td>';
      $message1 .= '<td style="background: #FFFFC2">' . $arecord->htmlValue('completedtime') . '</td>';
      $message1 .= '<td style="background: #FFFFC2">' . $arecord->htmlValue('remedy') . '</td></tr>';
    }
    $message1 .= "</table></body></html>";

//

    $message1 .= '<br>Closed Items - closed TODAY.  <br>';

//second table...............................
//$list1 = df_get_records_array('pr_downtime1', array('closed'=>"=1", '-limit'=>'20')); 
    $datefirst = date("m/d/Y", strtotime('-0 days'));
    $datelast = date("m/d/Y", strtotime('+1 days'));
    echo 'Debugging info:  <br>';
    echo $datefirst;
    echo ' ';
    echo $datelast;
    echo '<br>';

    $list1 = df_get_records_array('pr_downtime1', array('completedtime' => ">=" . $datefirst . " AND <=" . $datelast, 'closed' => "=1", '-limit' => '30'));

    $message1 .= '<table cellpadding="5" cellspacing="0" border="1" bgcolor="#FFFFFF" style="background: #FEE5DF">';
    $message1 .= '<tr><th>Duration</th>';
    $message1 .= '<th>Called 4 help time</th>';
    $message1 .= '<th>Machine</th>';
    $message1 .= '<th>Problem</th>';
    $message1 .= '<th>Down</th>';
    $message1 .= '<th>Who Is On It</th>';
    $message1 .= '<th>Completed Time</th>';
    $message1 .= '<th>Remedy</th></tr>';


    foreach ($list1 as $arecord) {
      $message1 .= '<tr><td style="background: #FFFFC2">' . $arecord->htmlValue('down_length') . '</td>';
      $message1 .= '<td style="background: #FFFFC2">' . $arecord->htmlValue('called4helptime') . '</td>';
      $message1 .= '<td style="background: #FFFFC2">' . $arecord->htmlValue('machinenum') . '</td>';
      $message1 .= '<td style="background: #FFFFC2">' . $arecord->htmlValue('problem') . '</td>';
      $message1 .= '<td style="background: #FFFFC2">' . $arecord->htmlValue('down') . '</td>';
      $message1 .= '<td style="background: #FFFFC2">' . $arecord->htmlValue('whoisonit') . '</td>';
      $message1 .= '<td style="background: #FFFFC2">' . $arecord->htmlValue('completedtime') . '</td>';
      $message1 .= '<td style="background: #FFFFC2">' . $arecord->htmlValue('remedy') . '</td></tr>';
    }
    $message1 .= "</table></body></html>";

//

    $message1 .= '<br>Closed Items - closed YESTERDAY. <br>';

//third table...............................

    $datefirst = date("n/j/Y", strtotime('-1 days'));
    echo $datefirst;
    echo ' ';
    $datelast = date("n/j/Y", strtotime('-0 days'));
    echo $datelast;
    echo '<br>';

    $list3 = df_get_records_array('pr_downtime1', array('completedtime' => ">= " . $datefirst . " AND <=" . $datelast, 'closed' => "=1", '-limit' => '30'));

    $query2 = array('completedtime' => ">=" . $datefirst . " AND <=" . $datelast, 'closed' => "=1", '-limit' => '30');
    echo json_encode($query2);
    echo '<br>';
    $query1 = array('completedtime' => '>=3/24/2015 AND <=3/25/2015', '-limit' => '30');
//echo json_encode($query1);
    //$list3 = df_get_records_array('pr_downtime1', array('completedtime' => '>=3/24/2015 AND <=3/25/2015' ,  '-limit'=>'30')); 

    $message1 .= '<table cellpadding="5" cellspacing="0" border="1" bgcolor="#FFFFFF" style="background: #FEE5DF">';
    $message1 .= '<tr><th>Duration</th>';
    $message1 .= '<th>Called 4 help time</th>';
    $message1 .= '<th>Machine</th>';
    $message1 .= '<th>Problem</th>';
    $message1 .= '<th>Down</th>';
    $message1 .= '<th>Who Is On It</th>';
    $message1 .= '<th>Completed Time</th>';
    $message1 .= '<th>Remedy</th></tr>';

    foreach ($list3 as $crecord) {
      $message1 .= '<tr><td style="background: #FFFFC2">' . $crecord->htmlValue('down_length') . '</td>';
      $message1 .= '<td style="background: #FFFFC2">' . $crecord->htmlValue('called4helptime') . '</td>';
      $message1 .= '<td style="background: #FFFFC2">' . $crecord->htmlValue('machinenum') . '</td>';
      $message1 .= '<td style="background: #FFFFC2">' . $crecord->htmlValue('problem') . '</td>';
      $message1 .= '<td style="background: #FFFFC2">' . $crecord->htmlValue('down') . '</td>';
      $message1 .= '<td style="background: #FFFFC2">' . $crecord->htmlValue('whoisonit') . '</td>';
      $message1 .= '<td style="background: #FFFFC2">' . $crecord->htmlValue('completedtime') . '</td>';
      $message1 .= '<td style="background: #FFFFC2">' . $crecord->htmlValue('remedy') . '</td></tr>';
    }
    $message1 .= "</table></body></html>";

//Message after all the tables...
    $message1 .= 'You can see these records in the app itself by visiting the address at: http://pmdsdata/ <br>';
    $message1 .= 'Click on:  Prodigy - (Production Status App). <br> Login in - user:read pw:read.  Click `Downtime List`.<br><br>';

// Add new lines throughout. Needed because outlook will not display tables properly without lots of new lines.
    $body1 = isset($message1) ? preg_replace('#(\\r\\n|\\n|\\r)#', '<br/>', $message1) : false;
    $body1 = preg_replace('#(______,|______)#', '<br/>', $body1);
    $body1 = preg_replace('#(</td></tr>)#', '</td></tr>' . PHP_EOL, $body1);



    if (mail($to1, $subject1, $body1, $headers1)) {

#echo '<meta http-equiv="refresh" content="0; url=http://pmdsdata3.stackpole.ca:8986/trakberry/tech_email_test/" />';  // using this redirect to send email report automaticlly from tech app			
      echo '<br><br><h1><span style="background-color:#00ff00;">Your email has been sent.</span></h1><br>';
    } else {
      echo '<br><br /><h1><span style="background-color:#ff0000;">There was a problem sending the email.</span></h1><br />';
    }
    echo '<br /><br /><br /><span style="font-size:16px;">Press the BACK button in your browser to go back.</span><br />';
  }

}
