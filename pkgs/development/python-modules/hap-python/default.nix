{ lib
, buildPythonPackage
, base36
, cryptography
, curve25519-donna
, ecdsa
, fetchFromGitHub
, h11
, pyqrcode
, pytest-asyncio
, pytest-timeout
, pytestCheckHook
, pythonOlder
, zeroconf
}:

buildPythonPackage rec {
  pname = "hap-python";
  version = "3.5.2";
  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "ikalchev";
    repo = "HAP-python";
    rev = "v${version}";
    sha256 = "1irf4dcq9fcqvvjbijkymm63n2s7a19igs1zsbv7y8fa5a2yprhd";
  };

  propagatedBuildInputs = [
    base36
    cryptography
    curve25519-donna
    ecdsa
    h11
    pyqrcode
    zeroconf
  ];

  checkInputs = [
    pytest-asyncio
    pytest-timeout
    pytestCheckHook
  ];

  # Disable tests requiring network access
  disabledTestPaths = [
    "tests/test_accessory_driver.py"
    "tests/test_hap_handler.py"
    "tests/test_hap_protocol.py"
  ];

  disabledTests = [
    "test_persist_and_load"
    "test_we_can_connect"
    "test_idle_connection_cleanup"
    "test_we_can_start_stop"
    "test_push_event"
    "test_bridge_run_stop"
  ];

  meta = with lib; {
    homepage = "https://github.com/ikalchev/HAP-python";
    description = "HomeKit Accessory Protocol implementation in python";
    license = licenses.asl20;
    maintainers = with maintainers; [ oro ];
  };
}
