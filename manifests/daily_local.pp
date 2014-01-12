#set a dailylocal var
define openbsd::daily_local($value){
  require openbsd::daily
  file_line{
    "openbsd_daily_${name}":
      line  => "${name}=${value}",
      match => "^${name}=",
      path  => '/etc/daily.local',
  }
}
