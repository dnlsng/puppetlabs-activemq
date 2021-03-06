class activemq::ssl {

  include activemq::params

  $passwd = hiera('activemq::ssl::password')

  java_ks { 'puppetca:truststore':
    ensure       => latest,
    certificate  => "${::settings::ssldir}/certs/ca.pem",
    target       => "${::activemq::params::amq_configdir}/broker.ts",
    password     => $passwd,
    trustcacerts => true,
  }

  java_ks { 'puppetca:keystore':
    ensure       => latest,
    certificate  => "${::settings::ssldir}/certs/${::clientcert}.pem",
    private_key  => "${::settings::ssldir}/private_keys/${::clientcert}.pem",
    target       => "${::activemq::params::amq_configdir}/broker.ks",
    password     => $passwd,
    trustcacerts => true,
  }
}
