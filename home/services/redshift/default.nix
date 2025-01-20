{
  services.redshift = {
    enable = true;
    provider = "manual";
    longitude = -79.3832;
    latitude = 43.6532;
    temperature = {
      day = 6500;
      night = 1900;
    };
    settings = {
      transition = 1;
    };
  };
}

