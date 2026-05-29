package ec.edu.epn;

import ec.edu.epn.service.BaggageFeeCalculator;
import ec.edu.epn.service.PassengerService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import static org.junit.jupiter.api.Assertions.assertEquals;


public class BaggageFeeCalculatorTest {

@Mock
private PassengerService passengerService;

@InjectMocks
    private BaggageFeeCalculator baggageFeeCalculator;

private BaggageFeeCalculator calculator1;

@BeforeEach
    public void examen1(){
    MockitoAnnotations.openMocks(this);
}

//Primera prueba para una maleta, 20 kg y un pasajero estandar
   @Test
    public void calcularEstandar(){
    double weight = 20;
    int bagCount = 1;
    Long passengerId = 1L;
    double tarifabase = 30.0;

    assertEquals(tarifabase, baggageFeeCalculator.calculateFee(weight, bagCount, passengerId), "El costo debe ser 30");





    }





}
