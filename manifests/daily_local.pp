#set a dailylocal var
define openbsd::daily_local($value){
  file_line{
    "openbsd_daily_${name}":
      line  => "${name}=${value}",
      match => "^${name}=",
      path  => '/etc/daily.local',
  }
}
