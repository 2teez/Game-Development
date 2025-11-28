// game.cpp

// A complete C++ Program
#include <SFML/Graphics.hpp>

class Game
{
    public:
        Game();
        void run();

    private:
        void processEvents();
        void update();
        void render();

        sf::RenderWindow m_window;
        sf::CircleShape m_player;
};

int main(int argc, char** argv)
{

    Game game;
    game.run();

    return 0;
}

Game::Game():
m_window{sf::VideoMode(640, 480), "SFML Application"},
m_player()
{
    m_player.setRadius(40.f);
    m_player.setPosition(100.f, 100.f);
    m_player.setFillColor(sf::Color::Cyan);
}

void Game::run()
{
    while(m_window.isOpen())
    {
        processEvents();
        update();
        render();
    }
}

void Game::processEvents()
{
    sf::Event event;
    while(m_window.pollEvent(event))
    {
        if (event.type == sf::Event::Closed)
            m_window.close();
    }
}

void Game::update()
{
}

void Game::render()
{
    m_window.clear();
    m_window.draw(m_player);
    m_window.display();
}
