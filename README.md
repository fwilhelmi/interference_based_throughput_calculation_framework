# Interference-based throughput calculation framework for Wireless Networks
### Author
* [Francesc Wilhelmi](https://github.com/fwilhelmi)

### Repository description
This framework allows to generate random 3D-networks and to compute the throughput they experience. Based on the nodes position and their configuration (channel and transmit power), the throughput is computed as the theoretical capacity (Shannon's equation). It is assumed a downlink transmission from an Access Point (AP) to a Station (STA).

__Important note:__ This framework does not consider any channel access protocol (e.g. CSMA), so it attempts to capture a full-interference regime to study the interactions between Wireless Networks. This code has been previously used in the following projects:
* [Implications of Decentralized Q-learning Resource Allocation in Wireless Networks](https://github.com/wn-upf/decentralized_qlearning_resource_allocation_in_wns): Q-learning is applied in WNs in order to determine the optimal channel and transmit power that enhances Spatial Reuse.
* [Collaborative Spatial Reuse in Wireless Networks via Selfish Multi-Armed Bandits](https://github.com/wn-upf/Collaborative_SR_in_WNs_via_Selfish_MABs): Multi-Armed Bandits are applied in WNs in order to determine the optimal channel and transmit power that enhances Spatial Reuse.

### System model
Throughput is computed according to nodes' location and configuration:
* Downlink traffic is assumed (from an AP to an STA)
* APs are constantly transmitting (full-interference regime)
* Throughput is computed according to the Signal-to-Interference-Noise-Ratio (SINR), which depends on the transmit power, the distance and the interference
* Co-channel interference is assumed (20 dBm drop for each channel distance)
* Path-loss is considered to include shadowing and obstacles effects (further implementation details can be found at the "./power_management_methods/power_matrix.m" function)

### Running instructions
To run the code, just 
1) "add to path" all the folders and subfolders in "./framework_throughput_calculation", 
2) Access to "framework_throughput_calculation" folder
3) Execute script "./framework_throughput_calculation/example_throughput_calculation.m" to see an example

### Contribute

If you want to contribute, please contact to francisco.wilhelmi@upf.edu
