package ec.edu.epn.service;

import org.springframework.stereotype.Service;

/**
 * Calcula las tarifas de equipaje para la aerolínea SkyRoute Airlines.
 * <p>
 * Reglas de negocio:
 * <ol>
 *   <li>Tarifa base: $30.0 por maleta.</li>
 *   <li>Exceso de peso: +$50.0 si una maleta pesa más de 23 kg.</li>
 *   <li>Beneficio VIP: primera maleta gratis si el pasajero es VIP
 *       y la maleta no excede 23 kg.</li>
 *   <li>Excepciones: weight ≤ 0, bagCount < 1, o passengerId nulo
 *       lanzan IllegalArgumentException.</li>
 * </ol>
 */
@Service
public class BaggageFeeCalculator {

    private final PassengerService passengerService;

    public BaggageFeeCalculator(PassengerService passengerService, double weight, int bagCount, Long passengerId, double totalBase) {
        this.passengerService = passengerService;
        this.weight = weight;
        this.bagCount = bagCount;
        this.passengerId = passengerId;
        this.totalBase = totalBase;
    }

    /**
     * Calcula la tarifa total de equipaje.
     *
     * @param weight       peso de cada maleta (kg)
     * @param bagCount     cantidad de maletas
     * @param passengerId  identificador del pasajero
     * @return costo total en dólares
     * @throws IllegalArgumentException si los parámetros no cumplen las restricciones
     */

    private double weight;
    private int bagCount;
    private Long passengerId;
    private double totalBase;


    public double calculateFee(double weight, int bagCount, Long passengerId) {

        //Cada maleta tiene el costo de $30.0
        double totalBase = bagCount * 30.0;

        //Para el exceso de peso

            if (weight > 23) {
                totalBase = totalBase + 50.00;
            }


        //Para el beneficio VIP

            if (passengerId != null && passengerService.isVip(passengerId) && weight <= 23) {
                totalBase = totalBase - 30.0;
            }


        //Para las restricciones mencionadas
        if (weight <=0 || bagCount <1 || passengerId == null){
             throw new IllegalArgumentException("Parámetros de equipaje inválidos");
        }

        return 0.0;
    }

}
