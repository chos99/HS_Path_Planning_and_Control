function mbc_clothoid_plot(a, rad, w, opening)
    % Setze Anfangspunkt und -winkel
    p.x = 0;
    p.y = 0;
    p.s1 = 0;
    p.s2 = 0;
    p.psi = 0;

    % Berechne obere Integrationsgrenze
    tau = abs(rad);
    xe = sqrt(tau * 2 * a^2);
    xe = -0.7854;
    % Setze a je nach Kurvenrichtung
    a = -a * sign(rad);

    % Definiere Funktionen für die Fresnel-Integrale
    if opening == 1
        s1_func = @(x) cos(-a/2 * x.^2 + a*xe.*x + p.psi);
        s2_func = @(x) sin(-a/2 * x.^2 + a*xe.*x + p.psi);
    else
        s1_func = @(x) cos(a/2 * x.^2 + p.psi);
        s2_func = @(x) sin(a/2 * x.^2 + p.psi);
    end

    % Diskretisiere die x-Werte für die Integration
    x_values = linspace(p.x, xe, 100);

    % Berechne die y-Werte der Klothoide
    s1_values = arrayfun(@(x) integral(s1_func, p.x, x), x_values);
    s2_values = arrayfun(@(x) integral(s2_func, p.x, x), x_values);

    % Plotte die Klothoide
    plot(s1_values, s2_values);
    axis equal;
    grid on;
    title('Klothoide');
    xlabel('X');
    ylabel('Y');
end